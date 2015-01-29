$(function () {

    initAccordion();
//    initDatepicker();
    initCalculations();
    initSelections();
//    initMailerBtn();

});


function initMailerBtn() {
    $('#send-btn').click(function () {
        send_mail($(this).attr('data_invoice'));
    });
}

function send_mail(invoiceNumber) {

    $.ajax({
        type: 'POST',
        url: 'mail_pdf',
        data: {invoice: invoiceNumber},
        success: function () {
            //console.log(invoiceNumber + ' sent'); //testing
        }
    });
}


function initSelections() {

    initSelection('#invoice_bank_details_id', 'invoices/refresh_bank_details');
    initSelection('#invoice_billers_id', 'invoices/refresh_biller');
    initSelection('#invoice_debtors_id', 'invoices/refresh_debtor');
    initSelection('#invoice_items_id', 'invoices/refresh_item');

    initSelection('#invoice_tax_codes_id', 'invoices/refresh_tax_code');
    initSelection('#invoice_freight_codes_id', 'invoices/refresh_freight_code');
    //initSelection('#invoice_qty', null);
}

function initDatepicker() {

    $('.datepicker').datepicker(
        {
            dateFormat: "dd M yy",
            showOn: "both",
            buttonImage: "/assets/calendar.gif",
            buttonImageOnly: true,
            buttonText: "Select date",
            inline: true
        }
    );
}

/* Initialise event when qty changed to make calculations */
function initCalculations() {
    $('#invoice_qty').change(function () {

        // Get the item price and calculate the line total based on the qty change
        var price = $('#item-price').html();
        var lineTotal = $(this).val() * price;

        $('#line-total').html(lineTotal);
        writeFormattedCurrency('#line-total-f',lineTotal);
        calculateTax();
        calculateInvoiceTotal();
    });
}


/* Calculate tax based on argument passed, and write in tax-calc div
 If no argument, then use value in hidden div 'tax-percent' */
function calculateTax(taxPercent) {

    // Get the line total and tax %
    var lineTotal = $('#line-total').html();
    var taxRate = typeof(taxPercent) === 'undefined' ? $('#tax-percent').html() : taxPercent;

    // Calculate the tax
    var taxCalc = lineTotal * taxRate/100;

    // Write the calculation, both raw and formatted
    $('#tax-calc').html(taxCalc);
    writeFormattedCurrency('#tax-calc-f', taxCalc);
}

function calculateFreight(freightAmt) {

    // Get the freight amt
    var freight = typeof(freightAmt) === 'undefined' ? $('#freight-calc').html() : freightAmt;

    // Write the calculation, both raw and formatted
    $('#freight-calc').html(freight);
    writeFormattedCurrency('#freight-calc-f', freight);
}

/* Calculate totals based on values for line, tax and freight, and write in total-calc div */
function calculateInvoiceTotal() {
    var total = getFloat('#line-total') + getFloat('#tax-calc') + getFloat('#freight-calc');
    $('#total-calc').html(total);
    writeFormattedCurrency('#total-calc-f', total);
}

/* Return the float value of the element html */
function getFloat(element) {

    var value = parseFloat($(element).html());
    return value;
}


function writeFormattedCurrency(element, value) {
    $(element).html('$' + $.number(value, 2));
}


function initSelection(elementId, ajaxUrl) {
    $(elementId).change(function () {
        var id = $(this).val();
        //send a call to refresh the logo div
        ajaxUrl != null ? sendAjaxCall(ajaxUrl, id) : '';
    });
}

function refreshList() {

    var $accordion = $("#accordion").accordion();
    var currentPanel = $accordion.accordion("option", "active");

    $('.form-view').empty();
    //update the list of current settings
    sendAjaxCall('settings/refresh_content', currentPanel);
}

function initAccordion(panel) {

    console.log("accordion init");

    var active = typeof(panel) !== 'undefined' ? panel : false;

    var icons = {
        header: "ui-icon-circle-arrow-e",
        activeHeader: "ui-icon-circle-arrow-s"
    };

    $("#accordion").accordion({
        collapsible: true,
        active: active,
        icons: icons
    });

    //Clear any form when a panel is selected
    $("#accordion").accordion({
        activate: function (event, ui) {
            $('.form-view').empty();
        }
    });
}

function getFlickrImages(form_name, photoset, container, size, callback, image_id_field, original_secret_field) {

    //append an image representing a nil value
    $('<img>').attr('id', 'no_image').appendTo($(container));

    // Load images from flickr:
    $.ajax({
        type: 'POST',
        url: 'account/logos/get_json_photos',
        data: {photoset_id: photoset}

    }).done(function (result) {

        loader.hideImage();

        var parsedFile = $.parseJSON($.parseJSON(result));
        var photos = parsedFile.photoset.photo;
        var baseUrl, imageId;

        // Add the images as links with thumbnails to the page:
        $.each(photos, function (index, photo) {

            baseUrl = 'http://farm' + photo.farm + '.static.flickr.com/' +
            photo.server + '/' + photo.id + '_' + photo.secret;


            //replace the forward slash '/' with '-' dash
            imageId = photo.farm + '.static.flickr.com-' +
            photo.server + '-' + photo.id + '_' + photo.secret;


            $('<img>')
                .prop('src', baseUrl + '_' + size + '.jpg')
                .addClass('image-link')
                .attr('id', imageId)
                .attr('alt', photo.originalsecret)
                .appendTo($(container));
        });
        //run the callback e.g. selectImage
        callback != null ? callback(form_name, container, image_id_field, original_secret_field) : '';
    });
}

function sendAjaxCall(path, id) {

    $.ajax({
        type: 'POST',
        url: path,
        dataType: 'script',
        data: {id: id},
        success: function () {
            //console.log('ajax call to ' + path + ' with id: ' + id + ' was successful');//for testing
        }
    }); //end ajax
}

/*
 Show the current Image by changing the css (border - red)
 Initialise the images for selection event
 Change the css (border - red) on selection
 */
function selectImage(form_name, container, image_id_field, original_secret_field) {

    //show which pic is currently selected (if any)
    var currentPicId = $('#' + form_name + '_' + image_id_field).val();
    //make this jquery safe by replacing period with escaped backslashes
    currentPicId = currentPicId.replace(/\./g, '\\.');

    if (currentPicId !== 'undefined') {
        $('#' + currentPicId).css({borderColor: 'red'});
    } else {
        $('#no_image').css({borderColor: 'red'});
    }

    $(container + ' img').on('click touchstart', function () {

        // change all images back to default border
        $(container + ' img').css({borderColor: 'lightgrey'});

        //place a red border around the selected image
        $(this).css({borderColor: 'red'});

        //assign the value selected from the chosen field to the input text field boxes
        $('#' + form_name + '_' + image_id_field).val($(this).attr('id'));
        $('#' + form_name + '_' + original_secret_field).val($(this).attr('alt'));
    });
}
