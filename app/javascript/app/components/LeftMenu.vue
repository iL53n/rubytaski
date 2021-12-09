<template lang="pug">
  q-drawer(
    side="left"
    show-if-above
    :mini="miniState"
    @mouseover="miniState = false"
    @mouseout="miniState = true"
    mini-to-overlay
    :width="220"
    :breakpoint="500"
    )
    q-scroll-area(class="fit")
      q-list
        q-item(class="bg-primary text-grey-1")
          q-item-section(avatar)
            div(id="square")
          q-item-section
            q-toolbar-title rubytaski
        div(class="text-primary")
          q-item        
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="library_books")
            q-item-section Dashboard
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="book")
            q-item-section Book
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="chrome_reader_mode")
            q-item-section Reader mode
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="done_all")
            q-item-section Done all
          q-item
          q-separator          
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="contact_support")
            q-item-section Support
          q-item(to="/" v-ripple)
            q-item-section(avatar)
              q-icon(name="info")
            q-item-section About  
</template>

<script>
  export default {
    data () {
      return {
        miniState: true
      }
    },
  }
</script>

<style scoped>
  #square {
    width: 25px;
    height: 25px;
    border-color: #fff200;
    border-style: solid;
    border-width: 4px
  }
</style>