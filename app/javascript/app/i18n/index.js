 import Vue     from 'vue'
 import VueI18n from 'vue-i18n'

 Vue.use(VueI18n)

 const messages = {
   en: {
     stat: {
      //  example: '{msg} world',
      today: 'Today',
      week: 'Week',
      goal: 'Goal'
     },
     heatmap: {
      title: 'Heatmap',
      unit: 'stars',
      locale: {
        months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        days: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        on: 'on',
        less: 'Less',
        more: 'More'
      }
    }
   },
   ru: {
    stat: {
      today: 'Сегодня',
      week: 'За неделю',
      goal: 'Цель'
    },
    heatmap: {
      title: 'Карта выполнения',
      unit: 'звезд',
      locale: {
        months: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
        days: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
        on: '-',
        less: 'Мнш',
        more: 'Блш'
      }
    }
  }
 }

 const i18n = new VueI18n({
   locale: 'en',
   fallbackLocale: 'en',
   messages: messages
 })

 export default i18n