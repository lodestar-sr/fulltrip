import { TRIP_ACTION } from "../actions/action-types";

const initialState = {
  filter: null,
};

export default (state = initialState, action) => {
  switch (action.type) {
    case TRIP_ACTION.SET_FILTER:
      return {
        ...state,
        filter: action.filter,
      };
  }

  return state;
};
