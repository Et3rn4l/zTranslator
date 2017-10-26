# zTranslator WIP

> A text-to-text-to-speech solution for dialog scripts. 
The app produces a translated file and can generate 
synthesized speech from text. 
Only works for Deadalus script files so far, but can be extended
for other file formats.

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# use file select to choose DIA_GM.d from root folder. 
Once file is loaded, a set of dialogs is displayed on the left side. 
By clicking on the translate button, dialogs from start index to end index
are getting translated sequentially in bunches of 20 requests.
By clicking on download translated files, it replaces the original dialog texts
with the translated and downloads the file
By clicking on synthesize speech, all dialogs with an filename, will be synthesized by Amazon Polly.
Voice cannot be chosen yet, but will be possible in the future.

Currently the translation data is stored in the localStorage for progressive translations
which has its limitations.
Future improvements will probably include a storage in Google FireStore

see image 1:
<h3 align="center">
    ![image-1](https://user-images.githubusercontent.com/10655837/32062300-65af076c-ba74-11e7-89d2-16c9ece5a7ee.PNG)
</h3>
<h3 align="center">
  ![image-2](https://user-images.githubusercontent.com/10655837/32062332-811eedbe-ba74-11e7-9def-34580475213e.PNG)
</h3>


