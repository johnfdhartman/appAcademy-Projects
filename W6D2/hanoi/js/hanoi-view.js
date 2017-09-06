class View {
  constructor(game, $el) {
    this.game = game;
    this.container = $el;
    this.setupTowers();
    this.render();
    this.fromTower = null;
  }

  setupTowers() {
    for(let i = 0; i < 3; i++) {
      $(this.container).append(`<ul order='${i}'></ul>`);
      // NEED TO MOVE
      // $('ul').eq(0).append(`<li order=${i}
      //   style="width:${33 + (i*33)}%;"></li>`);
        // OK
    }
    $('.hanoi').css( {
      display: 'flex',
      'justify-content': 'space-between',
    });

    $('ul').css({
      'background-color': 'white',
      'list-style': 'none',
      height: '300px',
      width: '30%',
      padding: 0,
      display: "flex",
      "align-items": "center",
      "flex-direction": "column",
      "border-bottom": "10px solid black"
    });

    $('ul').click((event) => {
      this.clickHandler(event);
    });
  }

  clickHandler(event) {
    const tower = this.findTower(event.target);
    console.log('event.target ', event.target);
    const order = $(tower).attr('order');
    console.log('order '+ order);
    if (this.fromTower != null) {
      // console.log('this.fromTower'+this.fromTower);
      // make move
      this.game.move(this.fromTower, order);
      this.fromTower = null;
    } else {
      this.fromTower = order;
    }
    this.render();
  }

  styleLis () {
    $('li').css({
      'background-color': 'black',
      height: '60px',
      "margin": "10px 0 10px 0",
      "border-radius": "50px"

    });
  }

  findTower (target) {
    if ($(target).attr('order')) {
      return target;
    } else {
      return $(target).parent();
    }
  }

  render () {
    for (let i = 0; i < 3; i++){
      let tower = this.game.towers[i]; // The tower
      let $tower = $(`ul[order="${i}"]`);      // the graphical representation
      this.renderTower(tower, $tower);

    }
    this.styleLis();
    // console.log(this.fromTower);
  }

  renderTower (tower, $tower) {
    $tower.empty();

    for (var i = 0; i < tower.length; i++){
      let disc = tower[i]; // 3, 2 or 1

      $tower.prepend(`<li
         style="width:${disc * 33.33}%;"></li>`);
    }
    // $tower.append(`<li order=${i}
    //   style="width:${33 + (i*33)}%;"></li>`);
  }
}

module.exports = View;
