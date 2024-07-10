// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
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
  