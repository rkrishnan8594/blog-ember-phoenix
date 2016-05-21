import Ember from 'ember';

export default Ember.Route.extend({
  model(params) {
    return this.store.findRecord('post', params.post_id);
  },

  actions: {
    save() {
      let self = this;
      this.currentModel.save().then(function(resp) {
        self.transitionTo('post', self.currentModel.id);
      });
    },
    cancel() {
      this.transitionTo('post', this.currentModel.id);
    }
  }
});
