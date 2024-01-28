<template lang="pug">
  div(class="q-ma-md")
    div(v-if="$q.platform.is.mobile")
      top-card-mob
    div(v-else)
      top-cards
    schedule
</template>

<script>
  import TopCards        from 'components/TopCards'
  import TopCardMob      from 'components/TopCardMob'
  import GeneralStat     from 'components/GeneralStat'
  import Schedule        from 'components/Schedule'

  export default {
    data () {
      return {
      }
    },
    components: {
      TopCards,
      TopCardMob,
      GeneralStat,
      Schedule
    }
  }
</script>

<style scoped></style>

