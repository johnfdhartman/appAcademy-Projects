/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const HanoiGame = __webpack_require__ (2);
const HanoiView = __webpack_require__ (3);
console.log(HanoiGame, 5);
$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(0);
module.exports = __webpack_require__(0);


/***/ }),
/* 2 */
/***/ (function(module, exports) {

class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  isValidMove(startTowerIdx, endTowerIdx) {
      const startTower = this.towers[startTowerIdx];
      const endTower = this.towers[endTowerIdx];

      if (startTower.length === 0) {
        return false;
      } else if (endTower.length == 0) {
        return true;
      } else {
        const topStartDisc = startTower[startTower.length - 1];
        const topEndDisc = endTower[endTower.length - 1];
        return topStartDisc < topEndDisc;
      }
  }

  isWon() {
      // move all the discs to the last or second tower
      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
  }

  move(startTowerIdx, endTowerIdx) {
      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
        return true;
      } else {
        return false;
      }
  }

  print() {
      console.log(JSON.stringify(this.towers));
  }

  promptMove(reader, callback) {
      this.print();
      reader.question("Enter a starting tower: ", start => {
        const startTowerIdx = parseInt(start);
        reader.question("Enter an ending tower: ", end => {
          const endTowerIdx = parseInt(end);
          callback(startTowerIdx, endTowerIdx)
        });
      });
  }

  run(reader, gameCompletionCallback) {
      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
        if (!this.move(startTowerIdx, endTowerIdx)) {
          console.log("Invalid move!");
        }

        if (!this.isWon()) {
          // Continue to play!
          this.run(reader, gameCompletionCallback);
        } else {
          this.print();
          console.log("You win!");
          gameCompletionCallback();
        }
      });
  }
}

module.exports = Game;


/***/ }),
/* 3 */
/***/ (function(module, exports) {

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


/***/ })
/******/ ]);