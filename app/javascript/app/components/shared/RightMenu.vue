<template lang="pug">
  q-drawer(
    side="right"
    show-if-above
    :mini="miniState"
    :width="260"
    :mini-width="10"
    :breakpoint="500"
    )
    q-scroll-area(class="fit")
      q-list
        q-item(style="background: rgb(248, 247, 253)" align="center")
          //- q-icon(size="md" name="date_range")
          q-toolbar-title(v-if="!miniState" class="text-blue-grey-10") {{ $t('heatmap.title') }}
          q-btn(
            class="q-mini-drawer-hide"
            dense
            round
            flat
            unelevated
            color="primary"
            icon="chevron_right"
            @click="miniState = true")
          q-btn(
            class="absolute"
            style="top: 280px"
            v-if="miniState"
            dense
            flat
            unelevated
            color="primary"
            icon="chevron_left"
            @click="miniState = false")
        heatmap
</template>

<script>
  import Heatmap from 'components/CalendarHeatmap'
  
  export default {
    data () {
      return {
        miniState: false
      }
    },
    components: {
      Heatmap
    }
  }
</script>

<style scoped></style>