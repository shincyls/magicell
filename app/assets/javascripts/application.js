// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require popper
//= require jquery
//= require_tree .

function loadjs(table, sortColumn, pageLength, dom) {
    
    $(table).DataTable({
      "order": [sortColumn],
      "search": {
        "caseInsensitive": true
      },
      "pageLength": pageLength,
      "dom": dom,
      language: { search: ''},
      "buttons": [
                {
                    extend: 'collection',
                    title: 'magicell_export',
                    text: 'Export',
                    buttons: [
                        'copy',
                        'excel',
                        'csv'
                    ]
                }
            ],
    });

    $('.dataTables_filter input[type="search"]').
    addClass('form-control form-control-sm small').
    attr('placeholder','Search by multiple keywords (eg: key1 key2)').
    css({'width':'20rem'});
};


function loaddtsum(table, sortColumn, pageLength, dom, tcol, scol ) {
    
    $(table).DataTable({
      "order": [sortColumn],
      "search": {
        "caseInsensitive": true
      },
      "pageLength": pageLength,
      "dom": dom,
      language: { search: ''},
      "buttons": [
                {
                    extend: 'collection',
                    title: 'magicell_export',
                    text: 'Export',
                    buttons: [
                        'copy',
                        'excel',
                        'csv'
                    ]
                }
            ],
       "footerCallback": function ( row, data, start, end, display ) {
            var api = this.api(), data;
     
            // converting to interger to find total
            var intVal = function ( i ) {
                return typeof i === 'string' ?
                i.replace(/[\$,]/g, '')*1 :
                typeof i === 'number' ?
                i : 0;
            };

            // Update footer by showing the total with the reference of the column index 
            $(api.column(tcol).footer()).html('Total');
     
            // computing column Total of the complete result
            var colSum = scol;
            var arrayLength = colSum.length;

            for (var i = 0; i < arrayLength; i++) {
                Total = api
                .column(colSum[i])
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
                $(api.column(colSum[i]).footer()).html(Total);
            }

        }
    });

    

    $('.dataTables_filter input[type="search"]').
    addClass('form-control form-control-sm small').
    attr('placeholder','Search by multiple keywords (eg: key1 key2)').
    css({'width':'20rem'});
};
