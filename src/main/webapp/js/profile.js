document.querySelector("input[type=file]").onchange = e => {
    document.getElementById("profileImg").src =
        URL.createObjectURL(e.target.files[0]);
};
/**
 * 
 */