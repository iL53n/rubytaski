<template lang="pug">
  q-drawer(show-if-above side="right" :width="260" :breakpoint="500")
    q-scroll-area(class="fit")
      q-list()
        q-item(style="background: rgb(248, 247, 253)" align="center")
          //- q-icon(size="md" name="date_range")
          q-toolbar-title(class="text-blue-grey-10") {{ $t('heatmap.title') }}
        heatmap
</template>

<script>
  import Heatmap from 'components/CalendarHeatmap'
  
  export default {
    data () {
      return {
      }
    },
    components: {
      Heatmap
    }
  }
</script>

<style scoped></style>