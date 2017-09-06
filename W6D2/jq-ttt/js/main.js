const View = require('./ttt-view');
const Game = require('./ttt-sol/game');

$( () => {
  window.game = new Game();
  window.view = new View(window.game, $('.ttt'));
});
