import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.store.createRecord('post');
  },

  actions: {
    save() {
      var post = this.currentModel;
      var self = this;
      post.save().then(function(resp) {
        self.transitionTo('posts');
      });
    },
    cancel() {
      var self = this;
      this.currentModel.destroyRecord().then(function(resp) {
        self.transitionTo('posts');
      });
    }
  }
});
