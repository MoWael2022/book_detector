class Failure {
final String messageError;

Failure(this.messageError);
}

class ServerError extends Failure{
   ServerError(super.messageError);

}