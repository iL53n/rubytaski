// Quasar framework
// import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import iconSet from 'quasar/icon-set/material-icons'
import '@quasar/extras/material-icons/material-icons.css'
import {
    Dialog,
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QBtn,
    QFooter,
    QToolbar,
    QToolbarTitle,
    QAvatar,
    QCard,
    QCardSection
} from 'quasar'

export default {
    config: {},
    components: {
        QLayout,
        QHeader,
        QDrawer,
        QPageContainer,
        QPage,
        QBtn,
        QFooter,
        QToolbar,
        QToolbarTitle,
        QAvatar,
        QCard,
        QCardSection
    },
    directives: {
    },
    iconSet: iconSet,
    plugins: {
        Dialog
    }
}
