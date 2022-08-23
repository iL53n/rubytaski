<template lang="pug">
  q-drawer(
    side="left"
    show-if-above
    :mini="miniState"
    @mouseover="miniState = false"
    @mouseout="miniState = true"
    mini-to-overlay
    :width="230"
    :breakpoint="1024"
    )
    q-scroll-area(class="fit")
      q-list
        q-item(class="bg-primary text-grey-1")
          q-item-section(avatar)
            a(href="/")
              div(id="square")
          q-item-section
            q-toolbar-title rubytaski
        div(class="text-primary")
          q-item        
          q-item(to="/dashboard")
            q-item-section(avatar)
              q-icon(name="dashboard")
            q-item-section
              div(class="text-subtitle1") {{ $t('menu.left.dashboard') }}
          q-item(to="/tasks_list")
            q-item-section(avatar)
              q-icon(name="library_add_check")
            q-item-section
              div(class="text-subtitle1") {{ $t('menu.left.tasks') }}
          q-item(to="/goals_list")
            q-item-section(avatar)
              q-icon(name="flag_circle")
            q-item-section
              div(class="text-subtitle1") {{ $t('menu.left.goals') }}
          q-item(to="/my_statistics")
            q-item-section(avatar)
              q-icon(name="insert_chart")
            q-item-section
              div(class="text-subtitle1") {{ $t('menu.left.statistics') }}
          q-item
          q-item
          q-separator          
          q-item(to="/feedback")
            q-item-section(avatar)
              q-icon(name="chat_bubble_outline")
            q-item-section {{ $t('menu.left.feedback') }}
          q-item(to="/about")
            q-item-section(avatar)
              q-icon(name="info_outline")
            q-item-section {{ $t('menu.left.about') }}
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