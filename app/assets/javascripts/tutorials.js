// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js

$(document).ready(function() {
  selectedValues = []

  //when page loads, add all selected topic ids into selectedValues
  tags = $('.selected-tag')

  if (tags) {
    for (var i = 0; i < tags.length; i++) {
      selectedValues.push(tags[i].id);
    }
  }

  //add new tags to selected tag list on click
  $('#add-tag').click(function() {
    selectList = $('#tag-options option:selected')
    divToAdd = createSelectedTagDiv(selectList, false)
    if (selectedValues.indexOf(selectList.val()) == -1) {
      $('#selected-tags').append(divToAdd);
      selectedValues.push(selectList.val());
    }
  })

  //add primary tag to front of selected tag list and remove
  //previous primary tag 
  $('#tutorial_primary_topic_id').change(function() {
    selectedOption = $('#tutorial_primary_topic_id option:selected');
    divToAdd = createSelectedTagDiv(selectedOption, true)

    //if primary already selected, remove it from selectedValues
    //and from html
    primary_topic_element = $('.primary')[0];
    if (primary_topic_element) {
      value = primary_topic_element.id;
      pos = selectedValues.indexOf(value);

      selectedValues.splice(pos, 1);
      primary_topic_element.remove();
    }

    //if primary tag was not on list of tags, add it
    if (selectedValues.indexOf(selectedOption.val()) == -1) {
      selectedValues.push(selectedOption.val());
    } else {
      $('#' + selectedOption.val()).remove();
    }

    $('#selected-tags').prepend(divToAdd);
  })

  $('form').submit(function() {
    $('#tutorial_tag_ids').val(selectedValues.join(','));
  })

  function createSelectedTagDiv(optionElement, isPrimary) {
    basicClassTag = "class='selected-tag";
    className = isPrimary == false ? basicClassTag + "'" : basicClassTag + " primary'";
    
    return "<div " +
           className +
           " id='" +
           optionElement.val() +
           "'>" + 
           optionElement.text() + 
           "</div>"; 
  }  

  
})
