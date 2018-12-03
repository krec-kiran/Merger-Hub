$form = $('#new_payment')

### If you're using Stripe for payments ###

payWithStripe = (e) ->
  e.preventDefault()

  ### Visual feedback ###

  $form.find('[type=submit]').html 'Validating <i class="fa fa-spinner fa-pulse"></i>'

  ### Create token ###

  expiry = $form.find('[name=cardExpiry]').payment('cardExpiryVal')
  ccData =
    name: $form.find('[name=cardHolderName]').val()
    number: $form.find('[name=cardNumber]').val().replace(/\s/g, '')
    cvc: $form.find('[name=cardCVC]').val()
    exp_month: expiry.month
    exp_year: expiry.year

  Stripe.card.createToken ccData, (status, response) ->
    if response.error

      ### Visual feedback ###

      $form.find('[type=submit]').html 'Try again'

      ### Show Stripe errors on the form ###

      $form.find('.payment-errors').text response.error.message
      $form.find('.payment-errors').closest('.row').show()
    else

      ### Visual feedback ###

      $form.find('[type=submit]').html 'Processing <i class="fa fa-spinner fa-pulse"></i>'

      ### Hide Stripe errors on the form ###

      $form.find('.payment-errors').closest('.row').hide()
      $form.find('.payment-errors').text ''
      # response contains id and card, which contains additional card details
      console.log response.id
      console.log response.card
      console.log response
      token = response.id
      plan = $form.find('#payment_plan').val()
      email = $form.find('#payment_email').val()

      # AJAX - you would send 'token' to your server here.
      # $.post('/payments', payment: { stripe_customer_token: token, email: email, plan: plan }).done((data, textStatus, jqXHR) ->
      #   $form.find('[type=submit]').html('Payment successful <i class="fa fa-check"></i>').prop 'disabled', true
      #   formClearEntry()
      #   # $('#new_payment')[0].submit()
      #   window.location.href = "/dashboard"
      #   return
      # ).fail (jqXHR, textStatus, errorThrown) ->
      #   $form.find('[type=submit]').html('There was a problem').removeClass('success').addClass 'error'

      #   ### Show Stripe errors on the form ###

      #   $form.find('.payment-errors').text 'Try refreshing the page and trying again.'
      #   $form.find('.payment-errors').closest('.row').show()
      #   return

      if status == 200
        $('#payment_stripe_customer_token').val(token)
        $('#new_payment')[0].submit()
    return
  return

$form.on 'submit', payWithStripe

### Fancy restrictive input formatting via jQuery.payment library###

$('input[name=cardNumber]').payment 'formatCardNumber'
$('input[name=cardCVC]').payment 'formatCardCVC'
$('input[name=cardExpiry').payment 'formatCardExpiry'

### Form validation using Stripe client-side validation helpers ###

jQuery.validator.addMethod 'cardNumber', ((value, element) ->
  @optional(element) or Stripe.card.validateCardNumber(value)
), 'Please specify a valid credit card number.'
jQuery.validator.addMethod 'cardExpiry', ((value, element) ->

  ### Parsing month/year uses jQuery.payment library ###

  value = $.payment.cardExpiryVal(value)
  @optional(element) or Stripe.card.validateExpiry(value.month, value.year)
), 'Invalid expiration date.'
jQuery.validator.addMethod 'cardCVC', ((value, element) ->
  @optional(element) or Stripe.card.validateCVC(value)
), 'Invalid CVC.'
validator = $form.validate(
  rules:
    cardNumber:
      required: true
      cardNumber: true
    cardExpiry:
      required: true
      cardExpiry: true
    cardCVC:
      required: true
      cardCVC: true
  highlight: (element) ->
    $(element).closest('.form-control').removeClass('success').addClass 'error'
    return
  unhighlight: (element) ->
    $(element).closest('.form-control').removeClass('error').addClass 'success'
    return
  errorPlacement: (error, element) ->
    $(element).closest('.form-group').append error
    return
)

paymentFormReady = ->
  if $form.find('[name=cardNumber]').hasClass('success') and $form.find('[name=cardExpiry]').hasClass('success') and $form.find('[name=cardCVC]').val().length > 1
    true
  else
    false

formClearEntry = () ->
  $form.find('[name=cardNumber]').val("")
  $form.find('[name=cardCVC]').val("")
  $form.find('[name=cardExpiry]').val("")

$form.find('[type=submit]').prop 'disabled', true
readyInterval = setInterval((->
  if paymentFormReady()
    $form.find('[type=submit]').prop 'disabled', false
    clearInterval readyInterval
  return
), 250)