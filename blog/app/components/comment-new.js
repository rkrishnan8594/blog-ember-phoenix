import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    save(comment) {
      var self = this;
      var comment = this.currentModel;
      comment.save().then(function(resp) {
        self.transitionTo('posts');
      });
    },
    cancel() {
      this.get('comment').destroyRecord();
    }
  }
});
