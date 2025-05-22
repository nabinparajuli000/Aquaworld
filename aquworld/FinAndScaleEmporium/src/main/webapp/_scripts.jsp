<%-- At the bottom of _navbar.jsp or in a new _scripts.jsp --%>
<div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 1050; display: flex; flex-direction: column; gap: 10px;"></div>

<script>
function showToast(message, type = 'info') { // type can be 'info', 'success', 'error', 'warning'
    const toastContainer = document.getElementById('toast-container');
    if (!toastContainer) return;

    const toast = document.createElement('div');
    toast.className = 'toast-message';
    toast.textContent = message;

    // Basic styling (can be enhanced with CSS classes)
    toast.style.padding = '15px';
    toast.style.borderRadius = '5px';
    toast.style.color = 'white';
    toast.style.minWidth = '250px';
    toast.style.boxShadow = '0 2px 10px rgba(0,0,0,0.2)';

    if (type === 'success') {
        toast.style.backgroundColor = '#28a745'; // Green
    } else if (type === 'error') {
        toast.style.backgroundColor = '#dc3545'; // Red
    } else if (type === 'warning') {
        toast.style.backgroundColor = '#ffc107'; // Yellow
        toast.style.color = 'black';
    } else { // info
        toast.style.backgroundColor = '#17a2b8'; // Blue
    }

    toastContainer.appendChild(toast);

    // Remove toast after a few seconds
    setTimeout(() => {
        toast.style.opacity = '0'; // Start fade out
        toast.style.transition = 'opacity 0.5s ease';
        setTimeout(() => {
            toast.remove();
        }, 500); // Remove after fade out
    }, 3000); // Display for 3 seconds
}
</script>