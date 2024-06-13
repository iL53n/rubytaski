<template lang="pug">
  q-footer(bordered name="mobile_footer" class="bg-grey-2 text-primary")
    q-card-actions(align="around" indicator-color="transparent" )
      q-btn(to="/dashboard" flat dense color="primary" size="lg" icon="dashboard")
      q-btn(to="/tasks_list" flat dense color="primary" size="lg" icon="library_add_check")
      q-btn(to="/goals_list" flat dense color="primary" size="lg" icon="flag_circle")
      q-btn(to="/my_statistics" flat dense color="primary" size="lg" icon="insert_chart")
    //q-tabs()
    //  q-route-tab(to="/dashboard" icon="dashboard" exact)
    //  q-route-tab(to="/tasks_list" icon="library_add_check" exact)
    //  q-route-tab(to="/goals_list" icon="flag_circle" exact)
</template>

<script>
export default {
  data () {
    return {

    }
  },
  computed: {
  },
  created () {
  },
  methods: {
  },
  components: {
  },
}
</script>

<style scoped>
</style>
