const validation = {
  email: {
    presence: {
      message: "Merci de renseigner un email",
    },
    email: {
      message: "Merci de renseigner un email valide",
    },
  },

  password: {
    presence: {
      message: "Merci de renseigner un mot de passe",
    },
    length: {
      minimum: 8,
      message: "Votre mot de passe doit faire au moins 8 caractères",
    },
  },
};

export default validation;
