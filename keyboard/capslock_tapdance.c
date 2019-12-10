

#include QMK_KEYBOARD_H
#include "keymap_belgian.h"


// LCTRL+B shorted to TMUX_LEADER
#define TMUX_LEADER LCTL(KC_B)


// tapdance keycode
enum td_keycodes {
  capslock
};

typedef enum {
  SINGLE_TAP,
  SINGLE_HOLD,
  DOUBLE_SINGLE_TAP
} td_state_t;



// create a global instance of the tapdance state type
static td_state_t capslock_state;
// function to determine the current tapdance state
int get_capslock_state (qk_tap_dance_state_t *state);
// `finished` and `reset` functions for each tapdance keycode
void capslock_finished (qk_tap_dance_state_t *state, void *user_data);
void capslock_reset (qk_tap_dance_state_t *state, void *user_data);

// determine the tapdance state to return
int get_capslock_state (qk_tap_dance_state_t *state) {
  if (state->count == 1) {
    if (state->interrupted || !state->pressed) { return SINGLE_TAP; }
    else { return SINGLE_HOLD; }
  }
  if (state->count == 2) { return DOUBLE_SINGLE_TAP; }
  else { return 3; } // any number higher than the maximum state value you return above
}

// handle the possible states for each tapdance keycode you define:

void capslock_finished (qk_tap_dance_state_t *state, void *user_data) {
  capslock_state = get_capslock_state(state);
  switch (capslock_state) {
    case SINGLE_TAP:
      register_code16(TMUX_LEADER);
      break;
    case SINGLE_HOLD:
      register_mods(MOD_BIT(KC_LSFT)); // for a layer-tap key, use `layer_on(_MY_LAYER)` here
      break;
    case DOUBLE_SINGLE_TAP: // when tapped twice it toggles capslock
      register_code16(KC_CAPS);
  }
}
void capslock_reset (qk_tap_dance_state_t *state, void *user_data) {
  switch (capslock_state) {
    case SINGLE_TAP:
      unregister_code16(TMUX_LEADER);
      break;
    case SINGLE_HOLD:
      unregister_mods(MOD_BIT(KC_LSFT)); // for a layer-tap key, use `layer_off(_MY_LAYER)` here
      break;
    case DOUBLE_SINGLE_TAP:
      unregister_code16(KC_CAPS);
  }
}



// define `ACTION_TAP_DANCE_FN_ADVANCED()` for each tapdance keycode, passing in `finished` and `reset` functions
qk_tap_dance_action_t tap_dance_actions[] = {
    [capslock] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, capslock_finished, capslock_reset),
};