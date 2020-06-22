import { USER_ACTION } from "../actions/action-types";

const initialState = {
  user: undefined,
};

export default (state = initialState, action) => {
  if (action.type === USER_ACTION.SET_CURRENT_USER) {
    return action.payload;
  }

  return state;
};
