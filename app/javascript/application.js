// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "../stylesheets/application"
import "../custom/jobs"
import "channels"

document.addEventListener("turbolinks:load", function() {
    const flashMessage = document.querySelector('.alert');
    if (flashMessage) {
      setTimeout(function() {
        flashMessage.remove();
      }, 5000);
    }
  });
  