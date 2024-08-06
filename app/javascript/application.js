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

  document.addEventListener("DOMContentLoaded", function() {
    const userTypeSelect = document.getElementById('user_type_select');
    const academicFields = document.getElementById('academic_fields');
  
    function toggleAcademicFields() {
      if (userTypeSelect.value === 'academic') {
        academicFields.style.display = 'block';
      } else {
        academicFields.style.display = 'none';
      }
    }
  
    toggleAcademicFields();
  
    userTypeSelect.addEventListener('change', toggleAcademicFields);
  });


  document.addEventListener("DOMContentLoaded", function() {
    const userTypeSelect = document.querySelector('.user-type-select');
    const cpfField = document.getElementById('cpf_field');
    const cnpjField = document.getElementById('cnpj_field');

    userTypeSelect.addEventListener('change', function() {
      if (this.value === 'academic') {
        cpfField.style.display = 'block';
        cnpjField.style.display = 'none';
      } else if (this.value === 'recruiter') {
        cnpjField.style.display = 'block';
        cpfField.style.display = 'none';
      } else {
        cpfField.style.display = 'none';
        cnpjField.style.display = 'none';
      }
    });
  });