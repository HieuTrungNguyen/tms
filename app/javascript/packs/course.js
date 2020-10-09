$(document).on('turbolinks:load', function() {
  /* Add Member to Course */
  $('body').on('click', '.js-btn__add-member', function(event) {
    var listCB = $('.user-remaining');
    var usersChecked = [];
    var courseId = $('#course-id').val();

    listCB.each(function(index, el) {
      if(el.checked) {
        var idUser = $(el).parent().parent().find('input[type="hidden"]').val();
        usersChecked.push(idUser);
      }
    });
    if(usersChecked.length == 0) {
      alert("Choose member to add, please!");
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
            alert("Course not found.");
          } else if(data.status == 403) {
            alert("User don't exist.");
          } else {
            alert("Add member to course successfully!");
          }
        }
      });
    }
  });

  /* Add Subject to Course */
  $('body').on('click', '.js-btn__add-subject', function(event) {
    var listSubject = $('.subject-remaining');
    var subjectsChecked = [];
    var courseId = $('#course-id').val();
    listSubject.each(function(index, el) {
      if(el.checked) {
        var idSubject = $(el).parent().parent().find('input[type="hidden"]').val();
        subjectsChecked.push(idSubject);
      }
    });
    if(subjectsChecked.length == 0) {
      alert("Please choose subject to add!");
    } else {
      $.ajax({
        url: '/courses/add_subject',
        method: 'GET',
        data: {
          subjectsChecked: subjectsChecked,
          courseId: courseId
        },
        success: function(data) {
          if(data.status == 404) {
            alert("Course not found.");
          } else if(data.status == 403) {
            alert("Subject don't exist.");
          } else {
            alert("Add subject to course successfully!");
          }
        }
      });
    }
  });

  /* Show Content in subjects of course */
  $('body').on('click', '.js-show-content__link', function(event) {
    $(this).parent().parent().find('.subject-content').toggleClass('hidden');
  });

  /* Delete More Member in Course */
  $('body').on('click', '.js-btn__delete-member', function(event) {
    var listSelectedUsers = $('.js-member__selected');
    var selectedUserIds = [];
    var courseId = $('#course-id').val();

    listSelectedUsers.each(function(index, el) {
      if(el.checked) {
        var idUser = $(el).parent().parent().find('input[type="hidden"]').val();
        selectedUserIds.push(idUser);
      }
    });
    if(selectedUserIds.length == 0) {
      alert("Choose member to delete, please!");
    } else {
      $.ajax({
        url: '/courses/delete_more_member',
        type: 'GET',
        data: {
          selectedUserIds: selectedUserIds,
          courseId: courseId
        },
        success: function(data) {
          if(data.status == 404) {
            alert("Course do not find.");
          } else if(data.status == 403) {
            alert("Member do not exist.");
          } else {
            alert("You deleted members successfully!");
          }
        }
      });
    }
  });
});
