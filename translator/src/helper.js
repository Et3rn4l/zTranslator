String.prototype.replaceAll = function(search, replacement) {
  var target = this;
  return target.replace(new RegExp(search, 'g'), replacement);
}

var AWS = require("aws-sdk");
AWS.config.update({
  region:'eu-west-1',
  accessKeyId: "AKIAJIAIAOQK5B57FD7A",
  secretAccessKey: "nwHtpS6ho1tnmBXydDtMDt44phQmg5y4KCONKTVK",
});

var toSpeech = function(text, filename, voice, context) {
  var self = this;
  var polly = new AWS.Polly();
  polly.synthesizeSpeech({
    TextType: 'text',
    OutputFormat: 'mp3',
    VoiceId: (voice) ? voice: 'Matthew',
    Text: text
  }, function(err, data) {
    if (data.AudioStream instanceof Buffer) {
      let blob = new Blob([data.AudioStream], { type: 'audio/mpeg' } )
      let link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob)
      link.download = filename + '.mp3'
      link.click();
      link.remove();
    }
    if (err) {
      document.write(err, err.stack);
      console.log(err, err.stack); // an error occurred
    }
  });
};
module.exports = {
  toSpeech: toSpeech
}
