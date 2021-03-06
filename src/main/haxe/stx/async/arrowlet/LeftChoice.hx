package stx.async.arrowlet;

import tink.core.Future;

using stx.Tuple;
import tink.core.Either in EEither;
import stx.data.*;
using stx.async.Arrowlet;


import stx.async.arrowlet.types.LeftChoice in TLeftChoice;

abstract LeftChoice<B,C,D>(TLeftChoice<B,C,D>) from TLeftChoice<B,C,D> to TLeftChoice<B,C,D>{
	public function new(arw:Arrowlet<B,C>){
		this = Arrowlet.fromCallbackWithNoCanceller(
			function(v:EEither<B,D>,cont:Sink<EEither<C,D>>){
				switch (v) {
					case Left(v) 	:
						new Apply().then(Left)(tuple2(arw,v),cont);
					case Right(v) :
						cont(Right(v));
				}
			}
		);
	}
}
