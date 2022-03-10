<template lang="pug">
  div(class="q-pa-xl row items-start q-gutter-xl")
    q-card(class="col-4" align="left")
      q-item
        q-item-section(avatar)
          q-file(borderless style="width: 80px" v-model="avatar")
            template(v-slot:file="{ index, file }")
              q-chip(class="full-width q-my-xs"
                
                square
                @remove="avatar = {}")
            q-avatar(size="80px")      
              q-img(src="https://cdn.quasar.dev/img/boy-avatar.png" @mouseover="showUpload = true" @mouseleave="showUpload = false")
                div(class="justify-center")
                  q-icon(v-if="showUpload" size="xl" name="photo_camera" class="text-indigo-1" @click="upload()")
            
        
        q-item-section
          q-item-label(class="text-h5") {{ user.nick_name }}
          q-item-label(caption) Registered: {{ user.created_at }}
      q-separator
      q-card-section
        q-card-section(class="text-subtitle1") Personal info
        p Email: {{ user.email }}
        p Date of birth: {{ user.date_of_birth }}
        p Parent: {{ user.parent }}
        p Locale: {{ user.locale }}
    q-card(class="col")
      q-item
        q-item-section(avatar)
          q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="settings")
        q-item-section(class="text-blue-grey-8" align="left")
          q-item-label(class="text-subtitle1") {{ $t('menu.top.profile.my_config') }}
          q-item-label(caption) {{ $t('menu.top.profile.my_config_description') }}
      q-separator
      q-card-section(horizontal)
        q-card-section Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        q-separator(vertical)
        q-card-section(class="col-4") col4Lorem ipsum dolor sit amet, consectetur adipiscing elit.

</template>

<script>

  export default {
    data () {
      return {
        showUpload: false
      } 
    },
    computed: {
      user: {
        get() {
          return this.$store.state.currentUser
        },
        set(value) {
          this.$store.commit('updateCurrentUser', value)
        }
      }
    },
    created() {

    },
    methods: {
      getUser() {

      },
      updateUser() {

      },
      uploadFile() {
        this.user.avatar = this.avatar
      }

    },
    components: {
    }
  }
</script>

<style scoped>
.profile-icon {
  border-radius: 5px;
  padding: 10px
}
</style>

