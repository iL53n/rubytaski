<template lang="pug">
  q-layout(view="lHr lpR fFf")
    header-component
    left-menu
    right-menu

    q-page-container(align="middle")
      router-view
</template>

<script>
  import HeaderComponent from 'components/shared/Header'
  import LeftMenu        from 'components/shared/LeftMenu'
  import RightMenu       from 'components/shared/RightMenu'
  
  export default {
    data () {
      return {
      }
    },
    components: {
      HeaderComponent,
      LeftMenu,
      RightMenu
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