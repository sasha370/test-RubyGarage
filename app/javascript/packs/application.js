// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "bootstrap"
require('jquery')
require('jquery-ui-dist/jquery-ui');
import "./best_in_place";
// import 'bootstrap/js/dist/util'
// import "bootstrap/toasts"

// Метод для обработки drag_drop событий внутри курса ( перетаскивание уроков)
// Ждем полной загрузки турболинков
$(document).on('turbolinks:load', function () {
    $('.tasks-sortable').sortable({
        cursor: "grabbing",
        //cursorAt: { left: 10 },
        // плейсхолдер прописали в application.scss
        // placeholder: "ui-state-highlight",

        update: function (e, ui) {
            let item = ui.item;
            let item_data = item.data();
            let params = {_method: 'put'};
            params[item_data.modelName] = {row_order_position: item.index()}
            // обновляем номера Уроков
            $.ajax({
                type: 'POST',
                url: item_data.updateUrl,
                dataType: 'json',
                data: params
            });
        },
        stop: function (e, ui) {
            console.log("stop called when finishing sort of cards");
        }
    });

    // $(".alert" ).fadeOut(3000);
    // $(".notice" ).fadeOut(3000);
    $('.toast').toast('show');

    $(".best_in_place").best_in_place();
    $('.best_in_place').bind("ajax:success", function () {$(this).closest('span').effect('highlight'); });

// Без обновления страницыб взято с RusRails
//
    window.addEventListener("load", () => {
        const element = document.querySelector("#new-task");
        element.addEventListener("ajax:success", (event) => {
            const [_data, _status, xhr] = event.detail;
            element.insertAdjacentHTML("beforeend", xhr.responseText);
        });

        // element.addEventListener("ajax:error", () => {
        //     element.insertAdjacentHTML("beforeend", "<p>ERROR</p>");
        // });
    });
});


