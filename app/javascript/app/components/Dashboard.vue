<template lang="pug">
  div
    top-cards
    schedule
</template>

<script>
  import TopCards        from 'components/TopCards'
  // import GeneralStat     from 'components/GeneralStat'
  import Schedule        from 'components/Schedule'


  export default {
    data () {
      return {
      } 
    },
    components: {
      TopCards,
      // GeneralStat,
      Schedule
    }
  }
</script>

<style scoped></style>

