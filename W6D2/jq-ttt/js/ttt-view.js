class View {
  constructor(game, $el) {
    this.game = game;
    this.setupBoard($el);
    this.bindEvents();
  }

  bindEvents() {
    let $lis = $('li');
    $lis.on('click', (event) => {
      if (!this.game.isOver()) {
        this.handleClick(event, this.game);
        window.setTimeout(this.checkGameWon.bind(this), 0);
      }
    });
  }

  handleClick(e, game){
    // 1. if it doesn't have unclicked, abort
    let li = e.target;
    if (!$(li).hasClass('unclicked')) return;

    // 2 extract pos from this(li)
    const pos = $(li).data().pos;
    // 3 send pos to game.playmove
    this.placeMark(li, game.currentPlayer);
    game.playMove(pos);
    $(li).removeClass('unclicked');
    $(li).addClass('clicked');
    //this.checkGameWon();
  }

  checkGameWon() {
    if (this.game.winner()) {
      alert(`${this.game.winner()} is winner!`);
    }
  }


  placeMark(li, player) {
    // $(li).text(player)
    $(li).append(`<div class="${player}">${player}</div>`);
    $(li).find('div').css({
      display: "inline-block",
      height: "100%",
      'font-family': 'sans-serif',
      'color': (player === 'x' ? 'red' : 'green'),

    });
    $(li).css({
      background: 'white'
    });
  }

  makeMove($square) {}

  /* Write a View.prototype.setupBoard method; it should make a grid to represent the board. Build the grid using an unordered list (<ul>). The cells can be represented inside the grid using <li> elements. By floating the <li> elements left and giving the <ul> a fixed width, the cells will appear on the same line and nicely wrap around to form a 3x3 grid. Set a border on the cells to make it look like a real grid. Style unclicked cells with a gray background. Change the background to yellow while the user :hovers over an unclicked cell. */
  setupBoard($el) {
    // 1. create the ul
    let $ul = $("<ul></ul>");
    $el.append($ul);
    // 2. create 9 lis -- don't forget 2 style!
    for (let i = 0; i < 3; i++){
      for (let j = 0; j < 3; j++){
        let $li = $("<li></li>");
        $li.addClass('unclicked');
        $li.data("pos", [i, j]);
        $('ul').append($li);

      }
    }
    //          --hover:background yellow
    $ul.css({
      "hover:background": "yellow",
      'display': 'border-box',
       "background": "gray",
       "width": '500px',
       'list-style': 'none',
       'height': '500px',
       'margin': '0',
       'padding': '0',
       'border': '5px solid black'
     });

    $('li').css({
                 display: 'flex',
                 'box-sizing': 'border-box',
                 'justify-content': 'center',
                 'align-items': 'center',
                 width: 'calc(33.33%)',
                 height: '33.33%',
                //  display: "inline-block",
                 float: 'left',
                 border: '5px solid black',
                 'background-color': 'gray',
                 margin: '0',
                 padding: '0',
                 'text-align': 'center',
                 'font-size': '8em'
               });

    $('.unclicked').hover( function () {
      if ($(this).hasClass('unclicked'))
        $(this).css("background-color", "yellow");
    }, function () {
      if ($(this).hasClass('unclicked'))
        $(this).css("background-color", "gray");
    });
  }
}

module.exports = View;
