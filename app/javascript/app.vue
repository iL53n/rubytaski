<template lang="pug">
  q-layout(view="lHr lpR fFf")
    header-component
    left-menu
    right-menu

    schedule
</template>

<script>
  import HeaderComponent from 'components/Header'
  import LeftMenu        from 'components/LeftMenu'
  import RightMenu       from 'components/RightMenu'
  import Schedule        from 'components/Schedule'
  
  export default {
    data () {
      return {
      }
    },
    components: {
      HeaderComponent,
      LeftMenu,
      RightMenu,
      Schedule
    }
  }
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
div {
  background: rgb(248, 247, 253)
}
</style>