import Vue     from 'vue'
import VueI18n from 'vue-i18n'

import { ru } from './locales/ru'
import { en } from './locales/en'

Vue.use(VueI18n)

const messages = { ru, en }

const i18n = new VueI18n({
  locale: 'en-US',
  fallbackLocale: 'en-US',
  messages: messages,
  silentTranslationWarn: true
})

export default i18n