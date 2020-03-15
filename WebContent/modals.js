// define login and registerModal DOM elements
let loginModal = document.getElementById('login-modal');
let registerModal = document.getElementById('register-modal');

// define login and register close DOM elements
let closeLogin = document.getElementById('close-login');
let closeRegister = document.getElementById('close-register');

// get all login- and registerlinks (depending on c:if)
let loginLinks = document.getElementsByClassName('login-link');
let registerLinks = document.getElementsByClassName('register-link');

// loop over each login link
for (let item of loginLinks) {
	// add click listener
	item.addEventListener('click', () => {
		loginModal.classList.add("is-active");
	});
}

// loop over each register link
for (let item of registerLinks) {
	// add click listener
	item.addEventListener('click', () => {
		registerModal.classList.add("is-active");
	});
}

// add click listener to close modal by clicking 'x'
closeLogin.addEventListener('click', () => {

	loginModal.classList.toggle('is-active');

});

// add click listener to close modal by clicking 'x'
closeRegister.addEventListener('click', () => {

	registerModal.classList.toggle('is-active');

});
