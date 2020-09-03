$(document).on('turbolinks:load', function() {
  $('body').on('click', '.btn-add-member', function(event) {
    var listCB = $('.user-remaining');
    var usersChecked = [];
    var courseId = $('#course-id').val();

    listCB.each(function(index, el) {
      if(el.checked) {
        var idUser = $(el).parent().next().next().find('input[type="hidden"]').val();
        usersChecked.push(idUser);
      }
    });
    if(usersChecked.length == 0) {
      alert(I18n.t("Choose member to add, please!"));
    } else {
      $.ajax({
        url: '/courses/add_member',
        type: 'GET',
        data: {
          usersChecked: usersChecked,
          courseId: courseId
        },
        success: function(data) {
          if(data.status == 404) {
            alert(I18n.t("Course not found."));
          } else if(data.status == 403) {
            alert("User don't exist.");
          } else {
            alert("Add member to course successfully!");
          }
        }
      });
    }
  });

  /* Show Content in subjects of course */
  $('body').on('click', '.js-show-content__link', function(event) {
    $(this).parent().parent().find('.subject-content').toggleClass('hidden');
  });
});
