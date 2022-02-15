<template lang="pug">
  q-drawer(
    side="right"
    show-if-above
    :mini="miniState"
    :width="260"
    :mini-width="10"
    :breakpoint="1024"
    )
    q-scroll-area(class="fit")
      q-list
        q-item(style="background: rgb(248, 247, 253)" align="center")
          //- q-icon(size="md" name="date_range")
          q-btn(
            v-if="!miniState"
            flat
            no-caps
            class=" full-width text-blue-grey-10"
            :label="$t('heatmap.title')"
            @click="miniState = true"
            icon-right="chevron_right")
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
        //- 'v-if' if I want lazy loading
        div(v-show="!miniState")
          heatmap
</template>

<script>
  import Heatmap from 'components/CalendarHeatmap'
  
  export default {
    data () {
      return {
      }
    },
    computed: {
      miniState: {
        get() {
          return this.$store.state.miniStateRight
        },
        set(value) {
          this.$store.commit('updateMiniStateRight', value)
        }
      }
    },
    components: {
      Heatmap
    }
  }
</script>

<style scoped></style>