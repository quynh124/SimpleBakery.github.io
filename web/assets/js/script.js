
document.addEventListener('DOMContentLoaded', function() {
    var faqItems = document.querySelectorAll('.faq-question');

    faqItems.forEach(function(item) {
        item.addEventListener('click', function() {
            var answer = this.nextElementSibling;

            if (answer.style.display === 'block') {
                answer.style.display = 'none';
            } else {
                answer.style.display = 'block';
            }
        });
    });
});
