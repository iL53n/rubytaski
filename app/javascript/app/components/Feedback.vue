<template lang="pug">
  .q-pa-xl.row.items-start.justify-around.q-gutter-xl
    q-card.my-card
      q-card-section
        .text-h3.text-blue-grey-14 Feedback
      q-card-section
        q-btn-toggle(
          v-model="type"
          spread
          no-caps
          unelevated
          toggle-color="primary"
          color="grey-2"
          text-color="primary"
          :options=[ {label: 'Issue', value: 'issue'}, {label: 'Suggestion', value: 'suggestion'} ])
      q-card-section
        q-input(filled v-model="email" type="email")
          template(v-slot:prepend)
            q-icon(name="mail")
      q-card-section
        q-input(filled label="Subject:")
      q-card-section
        q-input(filled type="textarea" label="Your message:")
      q-card-section
        q-file(
          v-model="files"
          multiple
          accept=".jpg,.jpeg,.png,.gif"
          label="Upload files"
          filled
          use-chips)
          template(v-slot:prepend)
            q-icon(name="photo_camera")
      q-card-section
        q-btn.full-width(
          unelevated
          color="primary"
          label="Send"
          @click=""
          no-caps
        )
</template>

<script>

export default {
  data () {
    return {
      type: '',
      types: Array({label: 'Issue', value: 'issue'}, {label: 'Suggestion', value: 'suggestion'}),
      email: '',
      files: []
    }
  },
  computed: {
    currentYear() {
      return new Date().getFullYear()
    },

  },
  created() {
  },
  methods: {

  },
  components: {
  }
}
</script>

<style  scoped>
.my-card {
  width: 100%;
  max-width: 500px
  }
</style>

