<template lang="pug">
  div(class="q-pa-xl row items-start q-gutter-xl")
    q-card(class="col-4" align="left")
      q-item
        //- q-item-section(avatar)
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
        q-card-section
          .q-gutter-y-md.column
            q-input(square filled label="Email" v-model="user.email")
              template(v-slot:append)
                q-icon(name="email")
            q-input(square filled label="Date of birth" v-model="user.date_of_birth" mask="date")
              template(v-slot:append)
                q-icon(name="calendar_today")
                  q-popup-proxy(ref="qDateProxy" transition-show="scale" transition-hide="scale")
                    q-date(v-model="user.date_of_birth")
                      div(class="row items-center justify-end")
                        q-btn(v-close-popup label="Close" color="primary" flat)
            q-select(square filled label="Locale" v-model="user.locale" :options="localesOptions")
              //- template(v-slot:append)
              //-   q-icon(name="language") 
          p(v-if="user.parent") Parent: {{ user.parent }}

        q-card-section
          q-banner(v-if="bannerShow" inline-actions rounded class="bg-green-1")
            .text-subtitle1.text-green-6 Сохранить изменения?
            template(v-slot:action)
              q-btn(@click="updateTasksOrder()" flat round color="green-7" icon="check")
              q-btn(@click="getTasks()" flat round color="red-7" icon="close")

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
        localesOptions: ['ru', 'en'],
        bannerShow: false,
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
    watch: {
      user(newValue, oldValue) {
        console.log(user)
        console.log(`Updating from ${oldValue} to ${newValue}`);
        this.bannerShow = true
      }
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

