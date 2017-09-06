const HanoiGame = require ('../jq-hanoi-sol/game');
const HanoiView = require ('../hanoi-view');
console.log(HanoiGame, 5);
$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});
