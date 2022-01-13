<template lang="pug">
    div
      q-banner(inline-actions rounded class="bg-amber-1")
        template(v-slot:avatar)
          q-icon(name="priority_high" color="lime-9")
        .text-subtitle1.text-lime-9 {{ $t('goals.warning_one_goal')}}
        //- template(v-slot:action)
        //-   q-btn(flat round color="lime-9" icon="close")

</template>

<script>

  export default {
    data () {
      return {

      } 
    },
    created() {

    },
    methods: {

    },
    components: {

    }
  }
</script>

<style scoped></style>

