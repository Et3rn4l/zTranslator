<template>
  <div id="app">
    <router-view/>
    <div class="app__footer">
      <span class="app__powered-by">powered by</span>
      <img class="app__powered-by-logo" src="./assets/logo.png">
    </div>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>

<style lang=stylus>
  .app
    &__footer
      display flex
      justify-content flex-end

    &__powered-by
      flex 1 1 auto
      display flex
      justify-content center
      flex-direction column
      text-align right
    &__powered-by-logo
      flex 0 1 auto
      max-width 3em
      max-height 3em

</style>
