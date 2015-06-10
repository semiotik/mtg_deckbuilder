Template.counterInput.events
  'click .btn-number': (e)->
    button = $(e.currentTarget)
    input = $("input[name='#{button.attr('data-field')}']")
    currentVal = parseInt input.val()
    if isNaN currentVal
      input.val('1')
    else
      min = parseInt input.attr('min')
      max = parseInt input.attr('max')
      if button.attr('data-type') == 'minus'
        input.val(currentVal - 1).change() if currentVal > min
        button.attr('disabled', true) if parseInt(input.val()) == min
      else if button.attr('data-type') == 'plus'
        input.val(currentVal + 1).change() if currentVal < max
        button.attr('disabled', true) if parseInt(input.val()) == max
  'change .input-number': (e)->
    input = $(e.currentTarget)
    min = parseInt input.attr('min')
    max = parseInt input.attr('max')
    currentVal = parseInt input.val()
    name = input.attr('name')
    if currentVal >= min
      $(".btn-number[data-type='minus'][data-field='#{name}']").removeAttr('disabled')
    if currentVal <= max
      $(".btn-number[data-type='plus'][data-field='#{name}']").removeAttr('disabled') if currentVal <= max