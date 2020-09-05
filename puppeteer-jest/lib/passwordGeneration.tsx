const passwordGeneration = () => {
    let pass = "";
    const str = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789~!@#$%^&*()_+|}{\":?><,./;'[]\\=-`";

    for (let i = 1; i <= 8; i++) {
        const char = Math.floor(Math.random() *
            str.length + 1);

        pass += str.charAt(char);
    }

    return pass;
};

export default passwordGeneration;
