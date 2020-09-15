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

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// Метод для обработки drag_drop событий внутри курса ( перетаскивание уроков)
// Ждем полной загрузки турболинков
$(document).on('turbolinks:load', function () {
    // берем элемент с классом .lesson-sortable
    $('.tasks-sortable').sortable({
        cursor: "grabbing",
        //cursorAt: { left: 10 },
        // плейсхолдер прописали в application.scss
        placeholder: "ui-state-highlight",

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

});



// Без обновления страницыб взято с RusRails
//
window.addEventListener("load", () => {
    const element = document.querySelector("#new-task");
    element.addEventListener("ajax:success", (event) => {
        const [_data, _status, xhr] = event.detail;
        element.insertAdjacentHTML("beforeend", xhr.responseText);
    });
    element.addEventListener("ajax:error", () => {
        element.insertAdjacentHTML("beforeend", "<p>ERROR</p>");
    });

});

