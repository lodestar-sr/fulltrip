import { SET_CURRENT_USER } from "../actions/action-types";

const initialState = {
  user: undefined,
};

export default (state = initialState, action) => {
  if (action.type === SET_CURRENT_USER) {
    return action.payload;
  }

  return state;
};
