<template>
  <div class="parser heading">
    <div class="parser__lang-select">
      <div >
        <label for="source-lang" class="parser__source-lang">Source language</label>
        <select v-model="sourceLang" id="source-lang" class="parser__source-lang">
          <option value="DE">DE</option>
          <option value="PL">PL</option>
          <option value="EN">EN</option>
        </select>
        <div>
          <label for="target-lang" class="parser__target-lang">Target language</label>
          <select v-model="targetLang" id="target-lang" class="parser__target-lang">
            <option value="DE">DE</option>
            <option value="PL">PL</option>
            <option value="EN">EN</option>
          </select>
        </div>
      </div>
      <div class="parser__encodings">
        <label for="source-encoding" class="parser__target-lang">Source file encoding</label>
        <input id="source-encoding" v-model="sourceEncoding" placeholder="e.g. utf-8, ANSI, iso-8859-2, iso-8859-1"/>
      </div>
      <div class="parser__encodings">
        <label for="target-encoding" class="parser__target-lang">Target file encoding</label>
        <input id="target-encoding" v-model="targetEncoding" placeholder="e.g. utf-8, ANSI, iso-8859-2, iso-8859-1"/>
      </div>
    </div>

    <div>{{ fileMeta }}</div>
    <input class="button" type="file" id="files" name="files[]" multiple @change="handleFileSelect"/>
    <div class="parser__output">{{ output }}</div>


    <div class="parser__actions">
      <label for="start-index" class="parser__target-lang">Start index</label>
      <input id="start-index" class="parser__start-index" @click.native.prevent.stop="$event.stopPropagation(); $event.preventBubble()" v-model="translationIndex" placeholder="Start index"/>
      <label for="limit" class="parser__target-lang">End Index</label>
      <input id="limit" class="parser__limit" @click.native.prevent.stop="$event.stopPropagation(); $event.preventBubble()" v-model="maxDialogs" placeholder="Enter the amount of dialogs per translation run"/>
      <button class="parser__translate-button button" :disabled="!rawDialogs.length" @click="initTranslate">
        translate {{maxDialogs}} dialogs
      </button>

      <button class="parser__download-button button" :disabled="!rawDialogs.length" @click="replaceAndDownloadFile">
        download translated file
      </button>
      <span>done {{ translationIndex}} / {{rawDialogs.length}}</span>

      <button class="parser__download-button button" :disabled="!rawDialogs.length" @click="synthesizeText">
        synthesize text
      </button>

      <button class="parser__download-button button" :disabled="!rawDialogs.length" @click="wrongSpeaker">
        wrong speaker check
      </button>
    </div>
    <div class="parser__results">


      <div class="parser__list">
        <h3>Actual "{{ sourceLang }}"</h3>
        <div class="parser__listitem"
             :class="{'parser__listitem--done': dialog.done}"
             v-for="(dialog, ind) in rawDialogs" >
          <div class="parser__listitem-index">{{ind + 1}}</div>
          <div class="parser__listitem-dialog">{{ dialog.dialog }}</div>
          <div class="parser__listitem-file">{{ dialog.speechFile }}</div>
        </div>
      </div>

      <div class="parser__translated" >
        <h3>Translated "{{ targetLang }}"</h3>
        <div class="parser__listitem" v-if="dialog"
             v-for="(dialog, ind) in rawDialogs" >{{ dialog.translation }} --- {{ dialog.speechFile }}</div>
      </div>
    </div>
  </div>
</template>

<script>

  function parseDeeplJSON(response) {
    if (response.status === 204) { // TODO generalize status checks
      return null;
    }
    if (typeof response.data === 'object') {
      return { res: response.data.result.translations.map(function(translation) {
                 return translation.beams[0].postprocessed_sentence;
               }).join(' '),
               input: JSON.parse(response.config.data).params.jobs[0]['raw_en_sentence'],
               index: JSON.parse(response.config.data).translationIndex };
    } else {
      return response.json();
    }
  }


  import axios from 'axios'
  import FileSaver from 'file-saver'
  import Helper from '../helper'

  var deeplApi = axios.create({
    baseURL: 'https://www.deepl.com/jsonrpc/',
    timeout: 5000000
  });
  var pollyApi = axios.create({
    baseURL: 'https://eu-west-1.console.aws.amazon.com/polly/api/',
    timeout: 2000
  });

  export default {
    name: 'zTranslator',
    data () {
      return {
        user: 'subject',
        sourceLang: 'DE',
        targetLang: 'EN',
        filename: 'DIA_GM.d',
        output: '',
        fileMeta: '',
        sentences: [],
        rawDialogs: [],
        translationIndex: 0,
        resolved: 0,
        maxDialogs: 100,
        sourceEncoding: 'utf-8',
        targetEncoding: 'utf-8'
      }
    },
    mounted: function() {
      let self = this;

      let content = JSON.parse(JSON.stringify(localStorage.getItem(this.filename)));
      if (content && content !== ''){

        // \(([^\,\s\r\n]*)(?=,) catches the speaker, but not the listener
        // "(.+)" captures the speech file name without braces
        // \/\/(.*)\r\n catches the text itself withouth line break and leading slashes
        let re = /AI_Output.*\(([^\,\s\r\n]*)(?=,).*"(.+)".*\/\/(.*)\r\n/gmi;
        let match = '';

        self.rawDialogs = (localStorage.getItem(this.targetLang + '__' + this.filename + '_RAWDIALOGS_ORIGINAL'))
          ? JSON.parse(localStorage.getItem(this.targetLang + '__' + this.filename + '_RAWDIALOGS_ORIGINAL')): [];
        if(true/*self.rawDialogs.length === 0*/){
          while ((match = re.exec(content)) != null) {
              if((match.length >= 3)){
                let dialog = match[3];
                let speechFile = match[2];
                let speaker = match[1];
//                console.log('match: ', match);
                self.rawDialogs.push({ dialog, speechFile, speaker })
              }
          }

          localStorage.setItem(this.targetLang + '__' + this.filename + '_RAWDIALOGS_ORIGINAL', JSON.stringify(self.rawDialogs));

        }

        /* resolve all promises synchronously */
//        axios.all(translations)
//          .then(axios.spread(function () {
//
//            dialogs = arguments;
//            [].forEach.call(arguments, function(sentence) {
//
////              console.log('sentence: ', sentence);
//              self.output = self.output.replace(sentence.input, ' ===== ' + sentence.res);
//            });
//            console.log('arguments: ', arguments.length);
//            localStorage.setItem('GM_Dialogs', JSON.stringify(arguments));
//
//          })).catch(function(err) { /*console.log('err: ', err);*/ });
//
////        var blob = new Blob([content], {type: "text/plain;charset=utf-8"});
////        FileSaver.saveAs(blob, "GM translated.d");
//        self.output = content;
      }

    },
    methods: {
      wrongSpeaker: function(c) {
        this.rawDialogs.forEach(function(dia, index) {
          if (dia.speaker === 'self' || dia.speaker === 'other'){

          }else{
              console.warn(index+ " has wrong speaker with "+ dia.speaker);
          }
        });
        console.log("finished speaker entries check");
      },
      initTranslate: function(evt) {
        let self = this;
        let translatedDialogs = (localStorage.getItem(this.targetLang + '__' + this.filename + '_TRANSLATED_DIALOGS'))
          ? JSON.parse(localStorage.getItem(this.targetLang + '__' + this.filename + '_TRANSLATED_DIALOGS')): [];

        /* set translated Dialogs to done */
        if(translatedDialogs.length !== 0){
          self.rawDialogs = translatedDialogs.map(function(translated) {
            return {  dialog: translated.dialog,
              translation: translated.translation,
              speechFile: translated.speechFile,
              speaker: translated.speaker,
              done: translated.done,
              pending: translated.pending }
          });
        }

        //proceed to last translated index
        if (this.translationIndex === 0){
          this.rawDialogs.every(function(dialog) {
            return dialog.done && self.translationIndex++;
          })
        }
        console.log('this.translationIndex: ', this.translationIndex);
        this.rekursiveTranslation(evt);
      },
      rekursiveTranslation: function(evt) {
        let self = this;
        let dialog = (this.rawDialogs[this.translationIndex+1])
          ? this.rawDialogs[this.translationIndex+1]: this.rawDialogs[this.translationIndex];

        console.log('dialog: ', dialog);
        if (dialog && dialog.pending){
          dialog.pending = false;
          setTimeout(self.rekursiveTranslation, 5000);
        }else if (dialog && self.translationIndex < self.maxDialogs){
          console.log('launch new bunch with 20 promises: translationIndex - ', self.translationIndex);
          for(let i=0; i < 20; i++){
            let dialog = self.rawDialogs[self.translationIndex];
            if (dialog && dialog.done){
              self.translationIndex++;
              continue;
            }
            dialog.pending = true;
            self.translateSentence(dialog.dialog, self.translationIndex, self.sourceLang, self.targetLang) && self.translationIndex++;
          }
          setTimeout(self.rekursiveTranslation, 2000);
        }else {
          console.log('finished recursion self.sentences: ', self.rawDialogs);
          //safe translated dialogs before exiting
          localStorage.setItem(this.targetLang + '__' + this.filename + '_TRANSLATED_DIALOGS', JSON.stringify(self.rawDialogs));

          return;
        }

      },
      translateSentence: function(stringToTranslate, translationIndex, sourceLang, targetLang ) {
        var self = this;
        let jobs = stringToTranslate.split(/([\.\?\!\;])[\s\t\r\n]/);
        if (jobs.length >= 2) {
          jobs.forEach(function(elem, ind) {
            if (ind%2 === 1){
              jobs[ind-1] += elem;
            }
          });
          jobs = jobs.filter(function(elem, ind) {
            return ind % 2 === 0;
          });
        }
        jobs = jobs.map(function(sentence) {
          return {"kind":"default", "raw_en_sentence": sentence };
        });

//        console.log(translationIndex + ' jobs: ', jobs);
        return deeplApi.post('', {
          "jsonrpc":"2.0",
          "method":"LMT_handle_jobs",
          "params":{
            "jobs":jobs,
            "lang":{"user_preferred_langs":["EN","DE","PL"],
              "source_lang_user_selected": sourceLang,
              "target_lang": targetLang
            },
            "priority":-1
          },
          "id":2,
          "translationIndex": translationIndex
        })
          .then(parseDeeplJSON)
          .then(function(sentence) {
//            console.log('sentence: ', sentence);
            if(self.rawDialogs.length >= sentence.index){
                self.rawDialogs[sentence.index].dialog = sentence.input;
                self.rawDialogs[sentence.index].translation = sentence.res;
                self.rawDialogs[sentence.index].done = true;
                self.rawDialogs[sentence.index].pending = undefined;

              self.$forceUpdate();
            }
//
          })
          .catch(function(err) {
            console.log('err: ', err);
             /*set pending to false and done to false here, so another request can start.
             or call */
            self.translateSentence(stringToTranslate, translationIndex, sourceLang, targetLang );
            self.rawDialogs[translationIndex].done = false;
            self.rawDialogs[translationIndex].pending = undefined;
          });
      },
      replaceAndDownloadFile: function() {
        let self = this;
        let translatedDialogs = (localStorage.getItem(this.targetLang + '__' + this.filename + '_TRANSLATED_DIALOGS'))
          ? JSON.parse(localStorage.getItem(this.targetLang + '__' + this.filename + '_TRANSLATED_DIALOGS')): [];

        /* set translated Dialogs to done */
        if(translatedDialogs.length !== 0){
          self.rawDialogs = translatedDialogs.map(function(translated) {
            return {  dialog: translated.dialog,
              translation: translated.translation,
              speechFile: translated.speechFile,
              done: translated.done,
              pending: translated.pending }
          });
        }
        self.rawDialogs.forEach(function(dia) {
          var re = dia.speechFile+'"\\s*\\)[\\S\\s]*\\/\\/\\s*('+dia.dialog+')';
          var replacement = dia.speechFile+'"); //'+dia.translation;
          var diaStrings = self.output.split(new RegExp(re, 'g'));
          self.output = (diaStrings.length) ? diaStrings.join(replacement): self.output;
          var otherStrings = self.output.split(dia.dialog);
          self.output =  (otherStrings.length) ? otherStrings.join(dia.translation): self.output;
        })
        var blob = new Blob([self.output], { type: "text/plain;charset="+ self.targetEncoding });
        FileSaver.saveAs(blob, this.filename+"__translated.d");
      },
      synthesizeText: function() {
        var self = this;
        if (confirm("synthesize all "+ self.maxDialogs +"files?")){
          this.rawDialogs.forEach(function(dia, index) {
            if(index < self.maxDialogs){
              let voice = (dia.speaker==='self')? 'Brian': 'Matthew';
              Helper.toSpeech(dia.translation, dia.speechFile, voice);
            }
          })
        }
      },
      handleFileSelect: function(evt) {
        var self = this;
        var files = evt.target.files;

        for (var i = 0, f; f = files[i]; i++) {
          self.fileMeta =  + '' + (f.type || 'n/a') + ') - '  + f.size +
            ' bytes, last modified: ' + f.lastModifiedDate.toLocaleDateString();


          var reader = new FileReader();
          reader.onload = (function(theFile) {
//            console.log('theFile: ', theFile);
            return function(e) {
              localStorage.setItem(theFile.name, e.target.result);
              self.filename = theFile.name;
              self.output = e.target.result;
//              AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_00"); //Ich könnte dich begleiten.
//              console.log('e.target.result: ', e.target.result);
            };
          })(f);
          reader.readAsText(f, self.sourceEncoding/*'iso-8859-1'*/);

        }

      }
    }
  }
</script>

<style lang="stylus">
  .heading
    background #fafaf7
  .parser
    text-align left
    &__output
      margin 1em 0.5%
      width 49%
      border 1px solid grey
      overflow scroll
      max-height 20em
    &__results, &__actions
      border-top 1px solid lightgrey
      display flex
      flex-direction row
    &__list, &__translated
      margin 1em 0.5%
      flex 0 1 49%
      /*width 100%*/
      border 1px solid #eaeaea
      h3
        text-align center
        margin-top .5em
    &__listitem
      padding .25em
      display flex
      flex-direction row
      > div
        flex 1 1 auto
      &-index
        flex 0 1 1%
        padding-right .15em
        display flex
        justify-content center
        flex-direction column
        text-align left
      &-dialog
        flex 0 0 50%
        width 70%
        text-align left
      &-file
        flex 1 1 30%
        text-align left

      &:nth-of-type(2n)
        background-color #eaeaea
        &.parser__listitem--done
          background-color #66dd33!important
          border-bottom 1px solid #eaeaea
          border-top 1px solid #eaeaea
      &--done
        background-color #66dd33
    &__translate-button, &__download-button
      margin .5em
      padding .5em
      display block
    .button
      color black
      background-color white
      border-color #aaa
      border-radius .5em
      font-weight bold
      &:hover
        cursor pointer
      &:disabled
        background-color #f0f0f0
        color #cfcfcf

    &__source-lang
      flex 0 1 auto
      margin .5em
      &#source-lang
        margin-left 0

    &__target-lang
      flex 0 1 auto
      margin .5em
      &#target-lang
        margin-left 0

    &__lang-select
      display flex
      justify-content flex-end

    &__encodings
      display flex
      flex-direction column
    &__start-index, &__limit
      margin .5em .1em
      max-width 4em

</style>

