<template>
  <div class="heading">
    <h1>{{ msg }}</h1>

    <div v-for="elem in test"> {{elem}}</div>

  </div>
</template>

<script>
  var handleError = function(error) {
      console.log('error: ', error);
    var speechOutput;
    return speechOutput;
  };

  function parseDeeplJSON(response) {
    if (response.status === 204) { // TODO generalize status checks
      return null;
    }
    if (typeof response.data === 'object') {
      return response.data.result.translations[0].beams[0].postprocessed_sentence;
    } else {
      return response.json();
    }
  }

  function parseJSON(response) {
    if (response.status === 204) { // TODO generalize status checks
      return null;
    }
    if (typeof response.data === 'object') {
      return response.data;
    } else {
      return response.json();
    }
  }


  import FileSaver from 'file-saver'
  import streamSaver from 'streamsaver'

  var AWS = require("aws-sdk");
  AWS.config.update({
    region:'eu-west-1',
    accessKeyId: "AKIAJIAIAOQK5B57FD7A",
    secretAccessKey: "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",
  });
  var toGermanSpeech = function(text, context) {
    var self = this;
    var polly = new AWS.Polly();
    polly.synthesizeSpeech({
      TextType: 'text',
      OutputFormat: 'mp3',
      VoiceId: 'Matthew',
      Text: text
    }, function(err, data) {
        let blob = new Blob([data.AudioStream], { type: 'audio/mpeg' } )
        let link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob)
        link.download = 'test.mp3'
        link.click();
        link.remove();

      if (err) {
        document.write(err, err.stack);
        console.log(err, err.stack); // an error occurred
      }
//      else {
//        var speech = data;
//        console.log(speech);
//
//        if (data.AudioStream instanceof Buffer) {
//          var params = {
//            Body: data.AudioStream,
//            Bucket: "innohacks2017",
//            Key: "audio.mp3",
//            ACL: "public-read"
//          };
//          var s3 = new AWS.S3();
//          s3.putObject(params, function(err, data) {
//            if (err) console.log(err, err.stack); // an error occurred
//            else     {
//              console.log(data);
//              var url = 'https://s3-eu-west-1.amazonaws.com/innohacks2017/audio.mp3';
//              var ssml = '<audio src="' + url + '" />';
//              context.emit(':ask', ssml, 'reprompt');
//            }           // successful response
//          });
//        }
//        return 'this is not a valid result'
//      }
    });
  };



  import axios from 'axios'
  var deeplApi = axios.create({
    baseURL: 'https://www.deepl.com/jsonrpc/',
    timeout: 2000
  });
  var pollyApi = axios.create({
    baseURL: 'https://eu-west-1.console.aws.amazon.com/polly/api/',
    timeout: 2000
  });

  export default {
    name: 'zTranlator speech',
    data () {
      return {
        user: 'subject',
        msg: '121231232 Welcome to zTranslator',
        test: ['a', 'b', 'c']
      }
    },
    mounted: function() {
      var self = this;
      var speechOutput = '';

      var sentence = "Wiem, że to trudne, ale musisz to zrobić.";
      var source_lang = "PL";
      var target_lang = "DE";
      toGermanSpeech('Just got to do something fast.', self);

      const sentences = ["zumm		DIA_Wisp_15_00.WAV",
      "Kilof...	Hackebeil_01_00.WAV",
      "... Nie chce z tobš rozmawiac ...		DIA_Addon_Skinner_ToughguyNews_08_00.WAV",
      "Prosze, we? te miksture uzdrawiajšcš.		DIA_Addon_Brandon_GivePotion_15_00.WAV",
      "Widzimy cie, robaku. Nie uciekniesz nam.		DIA_NoName_ObsessedByDMT_19_00.WAV",
      "Otwarcie wrót to wielka przysluga dla naszego Mistrza, marny ?miertelniku. Na twym grobie postawimy kaplice ku jego chwale.		DIA_Brutus_ObsessedByDMT_19_00.WAV",
      "Zawróc. Póki jeszcze mozesz.		DIA_Engrom_ObsessedByDMT_19_00.WAV",
      "TWkrótce wszyscy bedš naszymi slugami. Twoje magiczne sztuczki na nic sie nie zdadzš.	 	DIA_Vino_ObsessedByDMT_19_00.WAV",
      "Nigdy nie zdolasz ocalic tej duszy, magu.		DIA_Malak_ObsessedByDMT_19_00.WAV",
      "Poddaj sie, magu, nie mozesz nas pokonac.		DIA_Sekob_ObsessedByDMT_19_00.WAV"];

      /*let sentencess = sentences.forEach(function(str) {
        let res = str.split(/\t+/);
        translation: {
            sentence: res[0] || '';
            filename: res[1] || 'default.txt';
        }
        console.log('res: ', res);

        deeplApi.post('', {
          "jsonrpc":"2.0",
          "method":"LMT_handle_jobs",
          "params":{
            "jobs":[{"kind":"default", "raw_en_sentence": res[0] }],
            "lang":{"user_preferred_langs":["EN","DE","PL"],
              "source_lang_user_selected": source_lang,
              "target_lang": target_lang
            },
            "priority":-1
          },
          "id":21
        })
          .then(parseDeeplJSON)
          .then(function(res) {
            console.log('res: ', res);
            toGermanSpeech(res, self);
          })
          .catch(handleError.bind(self));
      });*/

//      console.log('sentences: ', sentencess);


//      deeplApi.post('', {
//          "jsonrpc":"2.0",
//          "method":"LMT_handle_jobs",
//          "params":{
//            "jobs":[{"kind":"default", "raw_en_sentence": sentence}],
//            "lang":{"user_preferred_langs":["EN","DE","PL"],
//              "source_lang_user_selected": source_lang,
//              "target_lang": target_lang
//            },
//            "priority":-1
//          },
//          "id":21
//      })
//      .then(parseDeeplJSON)
//      .then(function(res) {
//        console.log('res: ', res);
//        toGermanSpeech(res, self);
//      })
//      .catch(handleError.bind(self));


//      pollyApi.post('create-speech-url',
//        {
//          lexiconNames: [],
//          outputFormat: "mp3-22050",
//          speechMarksTypes: [],
//          text: "Ich weiß, dass das schwierig ist, aber du musst es tun.",
//          textContentType: "text",
//          voiceId: "Hans"
//        },
//        {
//        headers: {
////          'Referer': 'https://eu-west-1.console.aws.amazon.com/polly/home/SynthesizeSpeech?region=eu-west-1',
////          'Cookie': 'pc_sessId=qa_qC8nLLI_G27wjuzJTFLK_NiQdmsRV9_I8f2VBros; aws-creds=2pgfjJE8JP0s5K5APp%2FIxCCezaoCpmtn4dBhfcn1pJzahprJvExx7Uj%2BCJsalrXQCwGT6YUac6%2FJ%0A78RZSMi%2BAAXUOcenURDuA%2FGjhmnAxPUYM2P0KPgOYjiCMyFD5sLPyTD9PF3XxT11uoEQ8HxR6wA3%0Apd63qZ6hT7gEYf3O1uIhdJZhKgluARlsygMBBad%2BBAOdOpmcRJ%2BSFDHaCCF%2FIEqVSch%2FWWAG4iVY%0ASycRRcxL5yWfYwCxnrBRLyGRCTKSR261fsSzYDF50i0EvoDU%2FEqPgE0e%2F3769XCcfwg%2F2VvDQyIM%0AIoNRh3unmkYpFgCT4Koiv6gmBw1Q9qgA3SKhTl1vdKiNLwNqoYSiuW3fQZ0Q3yfFdIGsymBsgDd9%0Ab3zfn1RQeDek%2FVD%2B8ABrq3TG7gOx0X26ANDN2JsBRyfCcs0TB89fDybzePI1KhN08A3%2Fw7KTCbkD%0AZUezr8Ir%2BLdEkJ8qwjCUb%2BivTTgMMgyxdf3rQ7OgUED4CjHol9461fG9ujav8pkOd3XYh%2F44Dv%2Fg%0A4gSjWMcxyEUAgxI%2Fv1s3QtbIibF25AX60%2FjOIDgv4J4j8iepp282ZXEHF%2BWAOj77nwcEiAz0pYdV%0Ay8cxmA7tRjbT96C0cdBpB23u9%2BRMc%2FkqFmIvQGKBLfA%2Bc7roIF1JweiZkOYPd1ZlNg1xMEs9Sdjp%0AadGuv%2BokgkEcACbjPNGM1a2sh3daeIKvyKO82Pq74dT6bhnlxyjW%2FuI9USw17uRVWRCZ4swNKyzF%0A8WgWap%2Bv8%2FWvWEqe7WkUMA9Q25s01TDa54zlbF8CPw4G%2FxQ3Sqo8HF%2BKd9pNrGopPYG00Xd8zViB%0AmuQ0MsQYBL0tBglt9%2BN%2BPSyGJGicWn%2B6qDhOa0%2BqfZWB9vt2W4FT3Pze4CFHDMKq6WnIDBP32QyR%0A9%2Fy%2BTKVFqzCc66izaEe2STyllhdNXPdYnFI4L1ojWVzQQEsv6684hNTVRvts%2BT7kj%2FVzwK%2F%2FAFJa%0AK9t%2FNaKP0zAmimMWYaaEQXbjExR2lPOXqoQJbEo0lptHWTu10HcMJtSp0tfYPDmG3cNMY5VyqWAZ%0AC1PEQ3Hxz01uzUcKrN8r7DC9WYHf4TF5pjMzGEAnVOnDDKJIv6qKyN9gIQoXdv64Ywsju1PfhEET%0AVQCQY8Q4dtRm2kruvIvuRCLoP%2FJeu34zggcYY1Ea3srYt2TtwNG2s1jqgwY6%2F2IzGoY7y6MslqUE%0A1YcCgLlxGJvgB9oEqVVs6yvUtVflVCIiLpF4vUwxN4lJfUEsnxlIcxe8beMDc%2F%2B4tEKjAGgArHUO%0ACXG4GPEgCW4C3doHEpEPwIB6AdVIw0vUmsqkkVrLOBYT%2FnksHS0Ro5NZiSO%2FKmv2qkXc9jfvnd0U%0AtyuIO51e0pPB7LUFen5N5YBpPffLMR2MROZHGibaA%2FIt5mFAt6LaiT2l0GBCCheGkSsCZQ3nS4yV%0AYgGfznL6b4z2cVFxht1BtF%2F8hJmSdNhAiJGEaHyb1QQ7S11%2F%2FzE6ZErAp8rhpaB9mGRsvgzMMljI%0AQHcaqv3%2BiKpoQPRfnKzSQQ1rROuOYetA1AJyQw%3D%3D; aws-addr=moLdX2cdBes9%2B0BooBge4UymHYmAmlSNGZ19fwiU9IjA8%2FmAyHizUQ%3D%3D; awsc-authTimer=%7B%22start%22%3A%221508081886852%22%2C%22signinStart%22%3A%221508081887243%22%2C%22freshAuth%22%3A%22false%22%2C%22adStart%22%3A%221508081887736%22%2C%22stop%22%3A%221508081887798%22%7D; noflush_pollyRegion=eu-west-1; aws-session-token="F91F35sjj9e54Yd/nvDRYsa6KhrOfag3pdp9T1lvwmZa7cG4hzlCG2fyKLtEuECtEWpftwIShH0oWQDSAieGrMfyCiFDbEvc3kjv8NBh/wBeLGeKB5laKDVVFczqxfHk+ABjTOSIeXVVdhaiJFmjoycDGgilZKFy+eUsufCeHj0UcXn59KZCnObGjj3YYPa99uDJiZUkyzY5WWZccKjLBlnee6JBfRljx8eLX11lzRI="; __utmv=194891197.%22Pqt8NGz53ytsJ0pyKKKuIReUbjzu%401AU5zFaebGfd4FBdhonLQfFrjHqz4Xo72nH%22; aws-target-static-id=1506793176944-310762; s_vnum=1509490800392%26vn%3D4; x-wl-uid=12NCfla5UjOO3bHkwymTeUZYCs3n+14FMBWIfmSi2YP90O8+H0sLIVO6Lu+UsgbWjwG7Vue9JSvwUmTwvg++VpA==; aws-ubid-main=182-5640802-3534184; aws-session-id-time=2082787201l; aws-session-id=147-1780919-3906430; aws-business-metrics-last-visit=1506943165019; aws_lang=en; appstore-devportal-locale=en_US; AMCVS_4A8581745834114C0A495E2B%40AdobeOrg=1; lc-main=en_US; lwa-context=9ab283a7b49c5ef2ee131d140326f36a; session-id=137-5077517-4037933; session-id-time=2082787201l; session-token="lqGc2wx8NIwo0Cuw3U0+h7g98UnN9LTlhHaezzpK7YTZc+zjC988YD8NiMIvALYnJkMQujQyI/fiXz+G7Uhz0frIg/OnU9oeJSGVGWjtHYrII7EAELkB+A1B785K5Vobuh2RwY5eX76LKzdDRljDVbcxNltGsDX5dma1Ncq2qu6AVGalOJxCNydD+gyozm+pRjE7v0K5Vh/4Yyy1Daulxk6v740b6oKK7LSBtQXPUOU="; x-main="SBvBm0VQYZj5mMGYWZpEYnkgz9l?UFPdeoMZTGxztK14DgMYHRaAabWOZ1wxpHz?"; at-main=Atza|IwEBIDp7GArN-J5WLkdJIbgGeoBo1-I4_GZZYzpCkRgWT4rzFQN-QF1iCKGnTeBfe57u7baGe24sz4yKtY4WleAmtajSnY9YW_9eTKSqPWYXDwUqDd_J0ls2U4CmVPWKGuR9HfY6zxt6X0BqdxiIfC4eY7kNpv23j8rP6L_aF3WQlrJEP0qWwI82zWZE1GBm4jBShRCyQafa88z64LzR1-igyyZxrleNjBGWouhaf6i--KK4GdJAbL1YtvhCcsuw3lFkZLS9rAiHAIjlka4IIOV3pdEJ3a3kRw12gxBp276tIR1uDiUCObK1SKY122b9G0C0fdOU_4NwDBLGQe08fiK4q4rGXk0ucp8Z11foziH0wuAxDCoQ8SHi144_gcWH-4wUxRFflczK6FHgyYn3cy4kBnKe; sess-at-main="GOLV5MLXzO+zMkluQzcEpMyh3l7eqfGLZGF+Sh8YEPo="; aws-account-alias=256608350746; aws-account-data=%7B%22marketplaceGroup%22%3A%22AWS%22%7D; aws-userInfo=%7B%22arn%22%3A%22arn%3Aaws%3Aiam%3A%3A256608350746%3Auser%2Finnohacks%22%2C%22alias%22%3A%22256608350746%22%2C%22username%22%3A%22innohacks%22%2C%22keybase%22%3A%22RCSU3DqQvYYrby%2BDE4G2epTPJAPF7t7VyID6aMA1PTI%5Cu003d%22%2C%22issuer%22%3A%22https%3A%2F%2Fwww.amazon.com%2Fap%2Fsignin%22%7D; AMCV_4A8581745834114C0A495E2B%40AdobeOrg=-1891778711%7CMCIDTS%7C17455%7CMCMID%7C04847592077390332567933113538162746144%7CMCAID%7CNONE%7CMCOPTOUT-1508074005s%7CNONE%7CvVersion%7C2.4.0; ubid-main=133-5866773-1412732; s_sq=%5B%5BB%5D%5D; devportal-session="6cHHDM6Y3RLLf0rM/Eu1hg/s3I8rQ7b++bm/1Kw5AHI+HYUUkAFrWCBUjpZHIwhOJfYPbGFTzoCWQw3AgbIrDrvh5ZTe9rgKXuELbqlKd9tmDf76rvf77smlg/SafRiu9VZ8zdfv+XpEgnXadPOUNxGqC1tEUcc+ayGcWCjr/5mqoNfXiKA7W9QWKQREeNF6VksDFmI+XiZQabBw2+DGqztIV7pULV+0sU29Wyx1C03FTUuU7EdxBMBZmDHnktVj+1rccldyjbf+75EMxrpqNkEERwHS4rCZ9GQcf+oHSWY1kYDHzSQmds048JL4PZLBXOSQ3u88OPDfUL9RKwcKOsVyfFTJZmU4EP4xTxG9jek="; s_lv=1508071561933; s_campaign=PS%7Cacquisition_DE%7Cgoogle%7Cenglish_config_b%7Caws_config_p%7Caws%20config%7C159751463476%7Cconfig%7Cp%7CDE; __utma=194891197.2001261592.1506793156.1508064782.1508081523.11; __utmc=194891197; __utmz=194891197.1508081523.11.3.utmccn=(referral)|utmcsr=google.de|utmcct=/|utmcmd=referral; s_sess=%20s_cc%3Dtrue%3B%20s_sq%3Dawsamazonregprod1%252Cawsamazonallprod1%252Cawsamazonregprod2%252Cawsamazonallprod2%253D%252526pid%25253Dawsjavascriptsdk%2525252Flatest%2525252Faws%2525252Fconfig%252526pidt%25253D1%252526oid%25253Dhttp%2525253A%2525252F%2525252Fdocs.aws.amazon.com%2525252FAWSJavaScriptSDK%2525252Flatest%2525252FAWS%2525252FConfig.html%25252523region-property%252526ot%25253DA%3B; pN=10; s_pers=%20s_invisit%3Dtrue%7C1508083418891%3B%20s_nr%3D1508081618893-Repeat%7C1515857618893%3B; s_vn=1538329145713%26vn%3D7; aws-mkto-trk=id%3A112-TZM-766%26token%3A_mch-aws.amazon.com-1506793178460-92909; aws-target-visitor-id=1506793176947-197798.26_23; aws-target-data=%7B%22support%22%3A%221%22%7D; _mkto_trk=id:112-TZM-766&token:_mch-aws.amazon.com-1506793178460-92909; aws-first-visit-2=0; JSESSIONID=178E0A3336CE8E517EE9E3E0935E0AA9; seance=%7B%22accountId%22%3A%22256608350746%22%2C%22iam%22%3Atrue%2C%22services%22%3A%5B%22AWSLambda%22%2C%22AmazonTTS%22%2C%22lambda%22%2C%22polly%22%5D%2C%22status%22%3A%22ACTIVE%22%2C%22exp%22%3A0%7D; s_fid=42BC13F8216D3905-1AE8EE8C18937AA4; s_dslv=1508082075731; s_dslv_s=Less%20than%201%20day; s_depth=8; s_invisit=true; s_nr=1508082075735-New; regStatus=registered; c_m=undefinedwww.google.deNatural%20Search; s_cc=true; noflush_awscnm=%7B%22hist%22%3A%5B%22s3%22%2C%22home%22%2C%22lam%22%2C%22b%22%2C%22iam%22%2C%22polly%22%5D%2C%22sc%22%3A%5B%5D%2C%22tm%22%3A%22tm-both%22%2C%22ea%22%3Atrue%7D; noflush_Region=eu-west-1; __utmb=194891197',
//          'X-Requested-With': 'XMLHttpRequest',
//          "x-pc-xsrf-token": "ZHRQeEVzMmZiVEI3bGVWX0RaSGliZWc2cmtOdXBpcU05Mk1mZkhGOXhJQXwtNzY1MDg4OTg2NTU1MTQzNDgwOHwxfDIwMTctMTAtMTVUMTY6MDc6NTQuODgwWg=="
//        },
//        url: 'create-speech-url',
//        data: {
//          lexiconNames: [],
//          outputFormat: "mp3-22050",
//          speechMarksTypes: [],
//          text: "Ich weiß, dass das schwierig ist, aber du musst es tun.",
//          textContentType: "text",
//          voiceId: "Hans"
//        }
//      })
//      .then(parseJSON)
//      .then(function(res) {
//        console.log('res: ', res, res.url);
//        toGermanSpeech(res, self);
//      })
//      .catch(handleError.bind(self));


//      pollyApi.get('', {
//        Text: "Ich weiß, dass das schwierig ist, aber du musst es tun.",
//        TextType: "text",
//        VoiceId: "Hans",
//        SampleRate: 22050,
//        OutputFormat: "mp3",
//        "X-Amz-Security-Token": "AgoGb3JpZ2luEDMaCWV1LXdlc3QtMSKAAiGnyqvjUUiZTCzd0c6b+O0im80hi0mbGQZY/Jo0wCo4ikGYdvnxzjC771y0EF+jbHw++VOTtRm+wtRJEHfYF5C/Wpl7VQXJqxodl2vWDEAzLCPlwvphUZA3X0oxooeG3klhdsGC+ovpt+OBB3MnakHTwa98T23E/IFKr/Tau+wlOtRsqIatbOkqWtjFyqBVUAdxRsWCKU97T/OZvojP5Ec+7s8NyZ3Ek4OTHJmsHRXrRVzfR8eXCpVLepzwQLNqeCHsaYmf0U9uRyNv1UatMQBiO92gYInAe2KreEMGWiRtCATPb0fZZ9OusQx/U0yrYVjm0nlzixnkQ7nDOOMqbXcq8gMISRAAGgwyNTY2MDgzNTA3NDYiDF/G6SOyswW8jAkdESrPA1J8KpMLErbaui4JSkUSj83qdOCnG8rPG5wDjYgN6juLmJIYoLb/LUEaSgj86lUH6CKGt5O6tloqQHOeDdv9M7/+D4QqKgXlhjijo8blcRog8Meb9xcXQ59JHykpkxG9SS8DMF1Eo7qMfuFykhyForQHvaKSzWbKry4joTXBaiDfDdv/fk7vWqxeLlQ7CRwKpriGBEPfNQ6hZ3wlkWpSUzVqsQzf1bO64slltue6/CbmUCn0jZCR0NQunYdPfcDcrwOu3tBAYl3UZQghCznh0ZZD1fdi03F9Qj4p3rsUc2IIL7KuSuJhMnAb7GlXySe4nR2hvi39dvzi/KTHePlFLYhVKhgousUH8AMSuwZ6306oRuCOHz9FWFvkLWEWRlpkYsmv3JLDPIlUYad4g1dlWm4OWDt+T7yzVXVtGMZq1ak87QKjxz7RoQChfVN88T+UfeM0fGznDdl27YENfnQ+mcf5pVn9UzZSG5ezzClIW5mrRYAEsq9cLhC6J2qO60xVqKyf4eciPUS8/Q81hXcIxgHxAsc7+C/yBvMBm4qLj8ZwkJDTEztCk87+ys5NGwiRHknZyLTgsvaOQW2tmrkV/BzjGZjxHgQCti1IZ3HwF9Qw7v2MzwU=",
//        "X-Amz-Algorithm": "AWS4-HMAC-SHA256",
//        "X-Amz-Date": "20171015T154347Z",
//        "X-Amz-Expires": 300,
//        "X-Amz-Credential": "ASIAJZ5FJMV7W7ZSWD3Q/20171015/eu-west-1/polly/aws4_request",
//        "X-Amz-Signature": "e290937ce24d0421ff808a85b3f3cededefd4b17cc4e269dcec66fe2ffa1278d"
//      })
//      .then(parseDeeplJSON)
//      .then(function(res) {
//        console.log('res: ', res);
//        toGermanSpeech(res, self);
//      })
//      .catch(handleError.bind(self));
    },
    methods: {}
  }
</script>

<style lang="stylus">
  .heading
    background blue
</style>

