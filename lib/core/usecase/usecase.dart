import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call([Params? params]);
}

@immutable
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
