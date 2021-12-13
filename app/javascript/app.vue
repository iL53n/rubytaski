<template lang="pug">
  q-layout(view="lHr lpR fFf")
    header-component
    left-menu
    right-menu

    q-page-container(align="middle")
      top-cards
      schedule
</template>

<script>
  import HeaderComponent from 'components/shared/Header'
  import LeftMenu        from 'components/shared/LeftMenu'
  import RightMenu       from 'components/shared/RightMenu'
  import TopCards        from 'components/TopCards'
  // import GeneralStat     from 'components/GeneralStat'
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
      TopCards,
      // GeneralStat,
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