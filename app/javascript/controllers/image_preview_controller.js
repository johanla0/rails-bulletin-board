import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'previewContainer',
    'input',
  ];

  showPreview() {
    this.previewContainerTarget.src = URL.createObjectURL(this.inputTarget.files[0]);
  }
}
